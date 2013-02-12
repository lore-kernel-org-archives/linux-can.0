From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] candump: Add timeout option if no message has been
 received
Date: Tue, 12 Feb 2013 18:38:38 +0100
Message-ID: <511A7E1E.3010407@hartkopp.net>
References: <511A4C8B.3030605@pengutronix.de> <1360687851-1849-1-git-send-email-alexander.stein@systec-electronic.com> <511A7428.8040202@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:41195 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404Ab3BLRim (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 12:38:42 -0500
In-Reply-To: <511A7428.8040202@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On 12.02.2013 17:56, Marc Kleine-Budde wrote:

> On 02/12/2013 05:50 PM, Alexander Stein wrote:
>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>> ---
>> Changes in v3 (v2 was bogus)
>> * Use strtol instead of atoi
>> * Change memcpy to direct struct copy
>>
>>  candump.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/candump.c b/candump.c
>> index bf3e8bb..457af9d 100644
>> --- a/candump.c
>> +++ b/candump.c
>> @@ -49,6 +49,7 @@
>>  #include <ctype.h>
>>  #include <libgen.h>
>>  #include <time.h>
>> +#include <errno.h>
>>  
>>  #include <sys/time.h>
>>  #include <sys/types.h>
>> @@ -121,6 +122,7 @@ void print_usage(char *prg)
>>  	fprintf(stderr, "         -d          (monitor dropped CAN frames)\n");
>>  	fprintf(stderr, "         -e          (dump CAN error frames in human-readable format)\n");
>>  	fprintf(stderr, "         -x          (print extra message infos, rx/tx brs esi)\n");
>> +	fprintf(stderr, "         -T <msecs>  (terminate after <msecs> without any reception)\n");
>>  	fprintf(stderr, "\n");
>>  	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets can be specified\n", MAXSOCK);
>>  	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n");
>> @@ -227,6 +229,7 @@ int main(int argc, char **argv)
>>  	int nbytes, i, maxdlen;
>>  	struct ifreq ifr;
>>  	struct timeval tv, last_tv;
>> +	struct timeval timeout, timeout_config, *timeout_current = NULL;
> 
> I'll change this into
> 	struct timeval timeout, timeout_config = { 0, 0 }, *timeout_current = NULL;
> 
> To make my old compiler happy.
> 
> Applied.


Fine :-)

A funny feature.

Tnx,
Oliver

