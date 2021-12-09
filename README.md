# README for `dataspace_embargo_lifter`

This command-line script runs the [DSpace embargo lifter](https://wiki.lyrasis.org/display/DSDOC5x/Pre-3.0+Embargo+Lifter+Commands) and reports output via email.

## Instructions

1. To run, uncomment and edit the environment variables at the top of the `embargo_lifter.sh` file and populate with the following variables:
  * `EMBARGO_EMAILS`
    * The email address(es) to which embargo reports should go whenever this script is run.  
    * NOTE: To add multiple email addresses, separater them by a comma with no whitespace.  
      Example: `person_a@address.com,person_b@address.com`
  * `DATASPACE_SUPPORT_EMAIL`
    * The email address users contact for DataSpace support
  * `DSPACE_PATH`
    * The full path to the DSpace utilities executable directory on the server

  **All values are stored in LastPass.**

1. To run the DSpace embargo lifter tool and send an email report of the output, execute the script as follows:

  ```bash
  $ ./embargo_lifter.sh
  ```

  You should see output as follows:

  ### Example: when embargoes are lifted

  ```bash
  Running embargo lifter...
Embargo output:
Lifting embargo from Item handle=99999/fk4z33939w, lift date=2021-11-01
Lifting embargo from Item handle=99999/fk4tb2k934, lift date=2020-08-14
Embargo report sent
  ```

  ### Example: when there are no embargoes to be lifted

  ```bash
  Running embargo lifter...
  Embargo output:
  No embargoes detected that need to be lifted.
  Embargo report sent
  ```

1.  An email report will be sent to the address(es) specified in the `EMBARGO_EMAILS` variable containing the embargo output displayed at the command line.

## Recommendations for installing and managing with cron

When scheduling with cron, pipe the stdout output to a log file, for example:

```cron
$HOME/dataspace_embargo_lifter/embargo_lifter.sh >> $HOME/embargo_lift.log
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pulibrary/dataspace_embargo_lifter.
