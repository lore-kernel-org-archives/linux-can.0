From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RFC: improve and consolidate state change and bus-off handling
Date: Sat, 03 Dec 2011 17:53:14 +0100
Message-ID: <4EDA53FA.2090105@hartkopp.net>
References: <4ED8948E.5090806@grandegger.com> <4ED89D50.9040401@pengutronix.de> <4ED9EBAB.4060701@sebastianhaas.info> <4ED9F790.2060308@hartkopp.net> <4EDA0DA2.1070206@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:31349 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1LCQxN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 Dec 2011 11:53:13 -0500
In-Reply-To: <4EDA0DA2.1070206@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

On 03.12.2011 12:53, Sebastian Haas wrote:

> Hello,
> 
> Am 03.12.2011 11:18, schrieb Oliver Hartkopp:
>> Hello Sebastian,
>>
>> nice to read that you're back on air ;-)
> I've started to implement a kind of a restbus simulation for Linux and I
> stumbled again over SocketCAN ;-) So I'm back on air.


Fine. When you set up a rest bus simulation probably the can-gw available in
Linux 3.2 and up is valuable for your use case:

http://patchwork.ozlabs.org/patch/112916/


>> E.g. in some vehicle setups an automatic
>> recovery from bus-off after 200ms is specified. If this is done by a 'special'
>> handler or just by the driver can not be seen from the network view.
> I'm not very familiar with the current API, but how do I as an application
> restart recovery manually. I suppose there is ioctl().


No this if done by 'ip' from the iproute2 package:

See http://lxr.linux.no/#linux+v3.1.4/Documentation/networking/can.txt#L646

Regards,
Oliver
