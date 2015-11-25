From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 25 Nov 2015 17:04:50 +0100
Message-ID: <5655DC22.4000302@hartkopp.net>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:22054 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbbKYQFY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 11:05:24 -0500
In-Reply-To: <5655CC8D.70508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

Hi Guillaume,

On 11/25/2015 03:58 PM, Marc Kleine-Budde wrote:
> On 11/25/2015 03:02 PM, Guillaume Picquet wrote:
>> Hi all,
>>
>> I prefer to ask first to those who know.
>>
>> What is the 'normal' way of setting CAN bitrate from user-space 
>> application ?
>> Is there a library for that ?
> 
> Yes -
> http://www.pengutronix.de/software/libsocketcan/download/libsocketcan-0.0.10.tar.bz2
> 
>> If no shall I use netlink ?
> 
> No - netlink parsing makes your brain hurt :D
> 

Using libsocketcan is the way to control the interfaces by an application
(which internally uses netlink).

The usual way to configure the interfaces system wide is the 'ip' tool from
the iproute2 package which comes with your preferred Linux distribution.

The way to configure CAN interfaces with 'ip' is described here:

https://www.kernel.org/doc/Documentation/networking/can.txt (see chapter 6.5)

E.g. you can use this script in Debian/Ubuntu setups then:

https://github.com/linux-can/can-misc/blob/master/etc/can_if

Regards,
Oliver
