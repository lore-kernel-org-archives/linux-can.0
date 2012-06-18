From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 22:03:12 +0200
Message-ID: <4FDF8980.7000509@hartkopp.net>
References: <4FDF67C3.6020201@hartkopp.net> <4FDF7DE1.6000803@pengutronix.de> <4FDF7F25.8040605@hartkopp.net> <4FDF8614.9040707@pengutronix.de> <4FDF87C3.5010209@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:20682 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2FRUDL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 16:03:11 -0400
In-Reply-To: <4FDF87C3.5010209@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.06.2012 21:55, Marc Kleine-Budde wrote:

> On 06/18/2012 09:48 PM, Marc Kleine-Budde wrote:
>> If you want to be super clean you can first make a patch that changes
>> the existing __attribute__((aligned(8))) to __aligned(8), and then add
>> your canfd series. If not, just mention it in the patch description
>> (While being here change can_fd to __aligned(8)).
>>
>> Err..this is a userspace header, I just tested it, headers_install
>> doesn't remove it. And userspace fails to compile with this. For now
>> stick to __attribute__((aligned(8))).
> 
> BTW: and it fails to compile due to a __kernel_sa_family_t which isn't
> defined on my ubuntu with 2.6.32er headers


__kernel_sa_family_t is defined in include/linux/socket.h but with

#ifdef __KERNEL__

around it.

typedef __kernel_sa_family_t    sa_family_t;

What do you compile?

If you compile a kernel -> it is defined.
If you compile an application -> it is not needed.

Regards,
Oliver
