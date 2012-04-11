From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 20:58:51 +0200
Message-ID: <4F85D46B.9050704@grandegger.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F852161.90706@hartkopp.net> <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com> <4F85CD8D.9070107@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55434 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760903Ab2DKS6z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 14:58:55 -0400
In-Reply-To: <4F85CD8D.9070107@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

On 04/11/2012 08:29 PM, Oliver Hartkopp wrote:
> On 11.04.2012 19:58, Fabio Baltieri wrote:
> 
> 
>> On Wed, Apr 11, 2012 at 8:14 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>>> I wonder if it makes more sense to add the LED trigger stuff into
>>> drivers/net/can/dev.c ?!?
>>
>> Of course that seems to be the obvious (=correct) place to trap this
>> stuff. The reason why I worked on upper layer is that I did not found
>> any generic place to trap tx/rx events in the dev file without
>> modifying every device driver, as while tx can be trapped in
>> can_get_echo_skb(), rx frames are handled directly to the network
>> layer.
> 
> 
> I think that depends heavily on the driver and therefore adding the
> can_led_tx() and can_led_rx() calls to the appropriate places is the most
> transparent implementation.

I would prefer to implement can_led_trigger (or can_led_event) passing a
mask defining the event (RX, TX or event something else).

Wolfgang.
