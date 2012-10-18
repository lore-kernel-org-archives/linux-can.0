From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Bitbake recipe building socketcan for angstrom
Date: Thu, 18 Oct 2012 05:31:19 -0600
Message-ID: <507FE887.3080705@mlbassoc.com>
References: <loom.20121018T125449-719@post.gmane.org> <507FE560.8070905@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.mlbassoc.com ([65.100.170.105]:38219 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab2JRLhC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Oct 2012 07:37:02 -0400
In-Reply-To: <507FE560.8070905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: rotesmofa <pascalkrauth@gmail.com>, linux-can@vger.kernel.org

On 2012-10-18 05:17, Marc Kleine-Budde wrote:
> On 10/18/2012 12:55 PM, rotesmofa wrote:
>> Hallo everyone,
>>
>> I am fighting with Bitbaking Socketcan for Angstrom with a 2.6.32 Kernel for my
>> Craneboard.
>
> Regarding the kernel. It's rather old, doesnt't support much CAN
> hardware and may have CAN related bugs. Better update to latest v3.6 or
> newer.
>
>> Currently I have a basic lag of understanding for the *.bb files. I simply want
>> to build socketcan for my board using either Eclipse with my Angstrom toolchain
>> or using Bitbake.
>
> If you want to use socketcan you have to switch on some kernel features:
>
> 	-> Networking support
> 	-> CAN bus subsystem support
> 		[ ] Raw CAN Protocol (raw access with CAN-ID filtering)
> 	-> CAN Device Drivers
> 		[ ] Platform CAN drivers with Netlink support
>
> + the driver you need.
>
> No need to change any bitbake files.
>
>> Can anyone guide me? I'am in India and have kind of a research project but there
>> is no support and I'am a Hardware Guy ;-)
>
> If you need support for the userspace tools in openembedded/angstrom you
> should contact they mailinglist.

Just build 'canutils' which is part of the meta-openembedded/meta-oe layer

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
