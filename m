From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Fri, 5 May 2017 19:26:58 +0200
Message-ID: <820d1a65-4bdb-d3cf-adcf-91daadfdb049@hartkopp.net>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
 <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
 <fcdec4f3-41b0-c248-24de-555474bc5dee@hartkopp.net>
 <cefbe7e3-6c84-55cf-e964-b73a2d8d3d72@iot.bzh>
 <74642ed6-012d-aaca-778a-c4a5af65fe3c@hartkopp.net>
 <a2dc8f51-77db-f4d2-783d-48f0acc1a217@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:21991 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdEER1H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2017 13:27:07 -0400
In-Reply-To: <a2dc8f51-77db-f4d2-783d-48f0acc1a217@iot.bzh>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>, linux-can@vger.kernel.org

Hi Romain,

On 05/05/2017 12:19 PM, Romain Forlot [IoT.bzh] wrote:

> Thanks for the links, I found out the same and make my test against the
> wrong device... My bad, once MTU correctly set, it works.
>
> I hoping that even if BCM socket filter use of FD frames, it could
> handle classic CAN frame too, like the RAW socket do.

You obviously think CAN FD is 'just longer' than CAN which is wrong.

A CAN frame with CAN ID 0x123 is something completely different than a 
CAN FD frame with CAN ID 0x123. It has a different representation on the 
wire and it can have a different signal descriptions.

Even a CAN FD frame with 8 bytes is something different than a CAN frame 
with 8 bytes.

> It doesn't, so I
> guess that description about signals must specify if it's using FD
> frames or not.

Yes you have to treat it different.

> Be able to also handle classic CAN frames avoid that.
>
> There is a limitation to not handle both ?

A single CAN BCM socket *can* handle both at the same time.

You have to specify two RX_SETUP jobs then:
One for CAN and one for CAN FD

The fact whether a BCM job is CAN_FD_FRAME type is a relevant distinction:

/*
  * helpers for bcm_op handling: find & delete bcm [rx|tx] op elements
  */
static struct bcm_op *bcm_find_op(struct list_head *ops,
                                   struct bcm_msg_head *mh, int ifindex)
{
         struct bcm_op *op;

         list_for_each_entry(op, ops, list) {
                 if ((op->can_id == mh->can_id) && (op->ifindex == 
ifindex) &&
                     (op->flags & CAN_FD_FRAME) == (mh->flags & 
CAN_FD_FRAME))
                         return op;
         }

         return NULL;
}


http://lxr.linux.no/#linux+v4.10.1/net/can/bcm.c#L717

Regards,
Oliver
