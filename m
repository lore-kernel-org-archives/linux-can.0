From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Error Active
Date: Mon, 14 Apr 2014 08:50:11 +0000
Message-ID: <945463a5ffbafb3300795ee2636584f9@grandegger.com>
References: <15704970.EHNVEi1RO0@lisa>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:49893 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbaDNIuN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Apr 2014 04:50:13 -0400
In-Reply-To: <15704970.EHNVEi1RO0@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

Hi Stefan,

On Mon, 14 Apr 2014 10:03:51 +0200, Steffen Rose <ro@emtas.de> wrote:
> Hello,
> 
> I write a generic application, that should work with different socketcan
> driver implementations. 
> I know, there are different possibilities to get the CAN controller
state.
> And I see, that different 
> implementation do not implement all of them.
> 
> What is the standard way to get the state change from Error Passive to
> Error Active?

Historically we only supported "increasing" state changes
"active->warning->passive->bus-off". A few recent drivers do 
also support "passive->warning->active" but most don't (yet).

> My current way (in short incomplete form):
> 
> can_err_mask_t err_mask = CAN_ERR_FLAG | CAN_ERR_CRTL | CAN_ERR_PROT |
> CAN_ERR_BUSOFF;
> setsockopt(mBSDSocket, SOL_CAN_RAW, CAN_RAW_ERR_FILTER, &err_mask,
> sizeof(err_mask));
> 
> got = read(mBSDSocket, &frame, sizeof(struct can_frame));
> if (frame.can_id & CAN_ERR_FLAG) {
>   if (frame.can_id & CAN_ERR_PROT) {
>     if (frame.data[2] & CAN_ERR_PROT_ACTIVE) {
> 
> => change to Error active

Yes, that would be the correct way but as I said above, only a few drivers
use CAN_ERR_PROT_ACTIVE (do a "grep -r CAN_ERR_PROT_ACTIVE
drivers/net/can").
...

> This will work with the Systec USB interface, but do not work with Peak,
> Beagle bone, EMS CPC.

Some time ago I have posted an RFC for providing "decreasing" state
changes
as well including proper bus-off recovery for the SJA1000. If would dig it
out in case you are interested.

> I have seen the implementation in the can utils.
> 
> I know, the libsocketcan implements a different way. But I cannot
extract
> the relevant parts. 
> And I think a have to poll the current state with it and I search an
event
> based mechanism.

It's not a matter of libsocketcan or ip/iproute2.

Wolfgang.

