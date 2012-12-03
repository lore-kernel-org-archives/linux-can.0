From: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Subject: Re: at91_can.c: Data transmission stops
Date: Mon, 03 Dec 2012 17:13:53 +0100
Message-ID: <50BCCFC1.3030105@rosetechnology.dk>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B61E1B.8040904@rosetechnology.dk> <50B61FE4.5090905@pengutronix.de> <50B62947.4090300@rosetechnology.dk> <50B629ED.40507@pengutronix.de> <50B63164.5090601@rosetechnology.dk> <50B63A8E.5010802@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([95.154.61.7]:48810 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2LCQN4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 11:13:56 -0500
In-Reply-To: <50B63A8E.5010802@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 11/28/2012 05:23 PM, Wolfgang Grandegger wrote:
> On 11/28/2012 04:44 PM, Henrik Bork Steffensen wrote:
>>
>> This patch only contains this tx spin_lock - the rest of the driver
>> contains changes too.
>>
>> e.g: "at91_write(priv, AT91_IER, 1<<  AT91_MB_TX_SINGLE_MB_NUM);"
>> Only using one mailbox for TX was part of an divide-and-conquer process,
>> but also because the data sheet errata suggested it for low bw
>> applications.
> Don't change two (or more) things at a time. Otherwise you don't know
> what really helped.
>
> Just my 0.01 EUR
>
> Wolfgang.
>
>
Hi

I completly agree, and only one thing is changed.
The other changes are older.

BTW testing of the patch is postponed because the test equipment is in 
use for another test.
I hope that we will get test time by the end of this week.

regards,
Henrik

