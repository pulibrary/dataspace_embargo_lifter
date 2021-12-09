# export EMBARGO_EMAILS="x";
# export DATASPACE_SUPPORT_EMAIL="x";
# export DSPACE_PATH="x";

email_addresses=$EMBARGO_EMAILS
email_subject="DataSpace Embargo Lifter Report for $(date '+%Y-%m-%d %T')"
echo "${email_subject}"
echo "Running embargo lifter...";

EMBARGO_LIFT=`${DSPACE_PATH}/bin/dspace embargo-lifter -l --verbose 2>&1`

embargo_message=$EMBARGO_LIFT

if [ -z "${EMBARGO_LIFT}" ]; then
embargo_message="No embargoes detected that need to be lifted."
fi

email_body="See automatic embargo lift report below:

${embargo_message}

Output has also been written to DSpace log.

Contact the DataSpace team at ${DATASPACE_SUPPORT_EMAIL} for support.";
echo -e "Embargo output: \n${embargo_message}"

/usr/bin/mail -aFrom:noreply-dataspace@princeton.edu -s "${email_subject}" "${email_addresses}" <<< "${email_body}"

echo "Embargo report sent"
