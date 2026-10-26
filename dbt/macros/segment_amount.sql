{% macro segment_by_quantile(column, n_buckets=4, partition_by=none) %}
    ntile({{ n_buckets }}) over (
        {% if partition_by %}partition by {{ partition_by }}{% endif %}
        order by {{ column }}
    )
{% endmacro %}