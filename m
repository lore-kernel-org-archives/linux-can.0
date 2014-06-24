From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] cansniffer: totally untested hack to reduce display update by factor of 10
Date: Tue, 24 Jun 2014 18:44:07 +0200
Message-ID: <d65e3040-e640-4c05-baa3-d97ce7a448b6@email.android.com>
References: <1403627167-28287-1-git-send-email-mkl@pengutronix.de> <53A9A96E.5030407@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60997 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379AbaFXQoL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 12:44:11 -0400
In-Reply-To: <53A9A96E.5030407@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, felix.seitz@thm-motorsport.de
Cc: linux-can@vger.kernel.org



On 24 June 2014 18:38:06 CEST, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>I'll check it and give a feedback.
>
>Btw. it needs a v3:
>
>>  /* time defaults */
>>  
>> -#define TIMEOUT 50 /* in 100ms */
>> -#define HOLD    10 /* in 100ms */
>> -#define LOOP     2 /* in 100ms */
>> +#define TIMEOUT 500 /* in 10ms */
>> +#define HOLD    100 /* in 10ms */
>> +#define LOOP      2 /* in 10ms */
>
>LOOP has to be *10 too.

Yes, if we want unchanged behaviour, which would be better for mainlining. With my patch the default is now 20ms. 

Marc
