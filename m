From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Tue, 10 Jul 2012 21:01:11 +0200
Message-ID: <4FFC7BF7.9070709@hartkopp.net>
References: <20120703232328.GD6616@ovro.caltech.edu> <4FF40A6E.1040709@grandegger.com> <20120704120736.GB417@vandijck-laurijssen.be> <4FF46E12.8060102@hartkopp.net> <4FFC01FF.3030801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:37936 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab2GJTBE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 15:01:04 -0400
In-Reply-To: <4FFC01FF.3030801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On 10.07.2012 12:20, Marc Kleine-Budde wrote:

> On 07/04/2012 06:23 PM, Oliver Hartkopp wrote:
>> Anyway we currently have the flexcan and the ican3 hardware that generally
>> supports a loopback on hardware level but looses the reference to the tx-skb
>> and therefore to the sk pointer which is used to identify the originating
>> socket for recv-own-msgs support.
> 
> For the record:
> Since v3.4-rc1 flexcan implements proper loopback. (The flexcan driver
> has been added before recv-own-msgs support has been implemented, so it
> didn't make any difference back then.)
> 


Yes. I did not want to state that the driver does not have a proper solution.
The point is that the flexcan driver has a hardware loopback (like the ican3)
but due to the lack of references in the CAN frame registers the (generally
nice) functionality cannot be used for us. sigh.

Regards,
Oliver
