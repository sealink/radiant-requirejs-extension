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
    script = tag.attr['script'] || 'main'
    if RAILS_ENV == 'production'
      js_modified_at = File.mtime("./public/javascripts/#{script}.min.js").strftime("%s")
      <<-JS
<script type='text/javascript'>
  //<![CDATA[
    var require = {
        baseUrl: "/javascripts/",
        urlArgs : "v=#{js_modified_at}"
    };
  //]]>
</script>
<script data-main="#{script}.min.js" src="/javascripts/require.js"></script>
      JS
    else
      "<script data-main='/javascripts/#{script}' src='/javascripts/require.js'></script>"
    end.html_safe
  end

end
