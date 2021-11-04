if [[  ! -f .embargo_env ]]; then
  echo "Embargo ENV file does not exist"
  exit 1
fi

export $(egrep -v '^#' .embargo_env | xargs)

email_addresses=$EMBARGO_EMAILS
email_subject="DataSpace Embargo Lifter Report for $(date '+%Y-%m-%d')"

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

echo "${email_subject}"
echo "${email_body}"

mail -aFrom:noreply-dataspace@princeton.edu -s "${email_subject}" "${email_addresses}" <<< "${email_body}"
