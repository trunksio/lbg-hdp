# lbg-hdp
```
To run:

cd lbg-hdp
docker-compose -p lbg -f examples/compose/multi-container.yml up
```
Then in another screen:
```
./regDomain.sh
on ipa server: do these manual steps:
#ipa passwd hadoopadmin
#kinit hadoopadmin@LBG.DEV
#ipa passwd cdcsa
#kinit cdcsa@LBG.DEV

./run.sh
```

