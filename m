From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: Fwd: CanOpen stack
Date: Fri, 13 Jan 2012 21:21:06 +0100
Message-ID: <4F109232.6030809@sebastianhaas.info>
References: <CAKvQZ_3=dUGXnbhXmce9RBZ3PTdrY_BcuqdiOnZdxSog_-63yg@mail.gmail.com> <CAKvQZ_2WdAqkPWs0uyAGtpKQ72_gRgrv3A3+YLMeC=hCEj-_yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:59703 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758933Ab2AMUVC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2012 15:21:02 -0500
In-Reply-To: <CAKvQZ_2WdAqkPWs0uyAGtpKQ72_gRgrv3A3+YLMeC=hCEj-_yQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

I'm not aware of anyone working on this.

If I understood you correctly you intend to bring the layer into the 
kernel? What benefit do you expect from this?

I think most things can be modeled using the bcm (PDOs, heartbeats, 
SYNC) in userspace with a good and reliable timing. Only SDOs might be 
necessary to be implemented in kernel space (e.g. socket(AF_CAN, 
CANOPEN_SDO). Or what do you think?

I'm interested to support your efforts as I want to support CANopen 
anyway in restcan (https://github.com/sebi2k1/restcan).

Am 21.12.2011 16:56, schrieb Willy Lambert:
> Hi all,
>
> I wonder if it exists any CanOpen layer to plug on socketCan. I know
> CanFestival, but it seems to be dying. Does any one of you know such a
> project ? Is there any reason why a potential project could not be
> mailined (expect of course the lack of people ) ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
