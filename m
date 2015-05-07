From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] add 'v' command response
Date: Thu, 07 May 2015 22:57:22 +0200
Message-ID: <554BD1B2.8070200@hartkopp.net>
References: <1431008428-22567-1-git-send-email-mkl@pengutronix.de> <554B75A1.8030407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:54108 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbEGU5c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 May 2015 16:57:32 -0400
In-Reply-To: <554B75A1.8030407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, bombilee <chenglung@gmail.com>
Cc: linux-can@vger.kernel.org

Hi all

On 05/07/2015 04:24 PM, Marc Kleine-Budde wrote:
> Hello bombilee,
> 
> On 05/07/2015 04:20 PM, Marc Kleine-Budde wrote:
>> diff --git a/slcanpty.c b/slcanpty.c
>> index c062a027da41..f485ac775a53 100644
>> --- a/slcanpty.c
>> +++ b/slcanpty.c
>> @@ -185,6 +185,13 @@ rx_restart:
>>  		ptr = 1;
>>  		goto rx_out;
>>  	}
>> +	/* check for 'v'ersion command */
>> +	if (cmd == 'v') {
>> +		sprintf(replybuf, "v1014\r");
> 
> Is there a special meaning behing "v1014"? Where does the string come from?

We *already* check for the version command!

But it has to be 'V' with upper case:

See http://www.can232.com/docs/can232_v3.pdf page 12:

Get Version number of both CAN232 hardware and software
This command is only active always.
Example: V[CR]
Get Version numbers
Returns: V and a 2 bytes BCD value for hardware version and
a 2 byte BCD value for software version plus
CR (Ascii 13) for OK. E.g. V1013[CR]

The SLCAN/Lawicel protocol is case sensitive!!

See T/t R/r S/s M/m commands.

A hunk could be to support lower case for the version information check too.

But IMO that's the wrong approach.

The application should send 'V' and not 'v' - and this should be fixed there.

What kind of application sends 'v' to get the version information?

Regards,
Oliver

> 
>> +		tmp = strlen(replybuf);
>> +		ptr = 1;
>> +		goto rx_out;
>> +	}
>>  
>>  	/* check for serial 'N'umber command */
>>  	if (cmd == 'N') {
>>
> 
> Marc
> 
