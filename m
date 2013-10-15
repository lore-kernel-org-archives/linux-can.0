From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next] Add broadcast manager documentation
Date: Tue, 15 Oct 2013 06:57:32 +0200
Message-ID: <525CCB3C.8050609@hartkopp.net>
References: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com> <525C48F8.1050907@hartkopp.net> <525C4DC0.5030107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:11322 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3JOE5f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Oct 2013 00:57:35 -0400
In-Reply-To: <525C4DC0.5030107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Brian Thorne <hardbyte@gmail.com>, linux-can@vger.kernel.org

On 14.10.2013 22:02, Marc Kleine-Budde wrote:
> On 10/14/2013 09:41 PM, Oliver Hartkopp wrote:

>> +  configuration message is defined. The basic BCM configuration message used
>> +  to communicate with the broadcast manager and the available operations are
>> +  defined in the linux/can/bcm.h include. The BCM message consists of a
> 
> Nitpick
> It's "include/uapi/linux/can/bcm.h" in recent kernel trees.
> 

AFAIK the uapi directory is the place where the 'user API' relevant header
files are /generated/ at build time. Finally these header files are copied to

	/usr/include/linux/...

in the different Linux distributions to be accessed by application developers.

So in the application C code it's still:

#include <linux/can.h>
#include <linux/can/raw.h>
#include <linux/can/bcm.h>

Right?

Regards,
Oliver


