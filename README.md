# submit-datadog-metric

Submit a generic metric to DataDog

## How Do

```sh
./submit-metric.sh -m <metric name> -v <metric value> -T <metric type> -t <ts> [tag1:value1] [tag2:value2]
```

## Meet The Arguments

* `-h` help<br />
	print usage and exit
* `-m` metric name<br />
	**REQUIRED**
* `-v` metric value<br />
	**REQUIRED**
* `-T` metric type<br />
	optional, default `0`
* `-t` timestamp<br />
	optional, default: now
* tags<br />
	optional (but encouraged)
	format should be `tag:value`

## GitHub Actions

```yaml
      - name: Checkout DD Metric Submitter
        uses: actions/checkout@v3
        with:
          repository: hedenface/submit-datadog-metric
          ref: 1.0.1
          path: datadog

      - name: Submit metric
        continue-on-error: true
        run: |
          ./datadog/submit-metric.sh -m my.metric -v 42 tag1:value1 tag2:value2 tag3:value3
        env:
          DD_API_KEY: ${{ secrets.datadog_api_key }}
```
