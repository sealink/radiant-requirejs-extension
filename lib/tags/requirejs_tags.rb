module RequirejsTags

  include Radiant::Taggable

  desc '
    *Usage:*

      <pre><code>
        <r:requirejs />
      </code></pre>
  '
  tag 'requirejs' do |tag|
    # In order to invalidate browser side .js caching,
    # we need to modify the url used by requirejs with a unique variable for each build
    #
    # To achieve this we read the built main.min.js last modified time
    # and use that with v query param appended as an urlArgs
    #
    # NOTE: requirejs looks for a 'window.require' for additional config
    if RAILS_ENV == 'production'
      js_modified_at = File.mtime("./public/javascripts/main.min.js").strftime("%s")
      <<-JS
<script type='text/javascript'>
  //<![CDATA[
    var require = {
        baseUrl: "/javascripts/",
        urlArgs : "v=#{js_modified_at}"
    };
  //]]>
</script>
<script data-main="main.min.js" src="/javascripts/require.js"></script>
      JS
    else
      '<script data-main="/javascripts/main" src="/javascripts/require.js"></script>'
    end
  end

end
