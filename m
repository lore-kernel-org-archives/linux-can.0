From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v3] can-gw: add a variable limit for CAN frame
 routings
Date: Fri, 11 Jan 2013 07:56:42 +0100
Message-ID: <50EFB7AA.8080200@hartkopp.net>
References: <50EDCE64.1090401@hartkopp.net> <50EFA90F.5020302@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:52035 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615Ab3AKG4o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jan 2013 01:56:44 -0500
In-Reply-To: <50EFA90F.5020302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

It fits in the original patch and context very well (only 4 lines more).

I'll send a v4 instead after testing.

Sorry for the noise.

Oliver

On 11.01.2013 06:54, Oliver Hartkopp wrote:

> Hello Marc,
> 
> once you applied this patch to your can-next tree, please tell me the git URL
> before asking Dave to pull it.
> 
> I turned out that this extension for can-gw hops enables an additional
> configuration possibility, i would like to add for the pull request too.
> 
> Tnx,
> Oliver
> 
> 
> On 09.01.2013 21:09, Oliver Hartkopp wrote:
> 
>> To prevent a possible misconfiguration (e.g. circular CAN frame routings)
>> limit the number of routings of a single CAN frame to a small variable value.
>>
>> The limit can be specified by the module parameter 'max_hops' (1..6).
>> The default value is 1 (one hop), according to the original can-gw behaviour.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> ---
>>
> 
> 
> (..)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


