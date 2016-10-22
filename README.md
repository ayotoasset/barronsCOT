# barronsCOT v0.1.0.9000

Retrieve and analize Barron's Commitments of Trader data.

## Getting Started

Barron's commitments of traders (COT) is a weekly data seed from Barron's web page
[Barron's COT ](http://www.barrons.com/public/page/9_0210-traderscommitments.html)

**barronsCOT** read the COT table from Barron's web page, store the data and analyze it.

- Retrieve COT weekly data
- Clean and store data
- Show several graphics representation

### Prerequisities

If you install from devtools you do not need to do anything else.

```
> devtools::install_github("mariope/barronsCOT")
```

## Running barronsCOT

The function available are:

### getBarronsCOT()

Retrieve COT weekly data fron Barron's web page.
This function hasn't parameters.

```
> getBarronsCOT()
```

## Built With

* R v3.2.2
* R Studio - version 0.99.903

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/mariope/cmcparse/tags). 

## Authors

* **Mario Pisa** - *Initial work* - [cmcparse](https://github.com/mariope/cmcparse)

## License

This project is licensed under the GPL-3 License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* To Open Source community.
