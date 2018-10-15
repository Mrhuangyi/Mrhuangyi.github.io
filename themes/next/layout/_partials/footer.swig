<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; 
{% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-star"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>
</div>
{% if theme.footer.counter %}
<span id="busuanzi_container_site_pv">本站总访问量<span id="busuanzi_value_site_pv"></span>次</span>

{% endif %}
<div class="powered-by">
<i class="fa fa-send-o"></i>
</div>
{% if theme.footer.powered %}

{% endif %}

{% if theme.footer.powered and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{% endif %}

{% if theme.footer.theme.enable %}

{% endif %}

{% if theme.footer.custom_text %}
  <div class="footer-custom">{#
  #}</div>
{% endif %}

