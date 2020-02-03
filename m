From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: can_create_echo_skb(): fix echo skb generation: always
 use skb_clone()
Date: Mon, 3 Feb 2020 14:48:02 +0100
Message-ID: <7ee9df43-2efb-ba57-c8a9-301bae12c0d7@pengutronix.de>
References: <20200124132656.22156-1-o.rempel@pengutronix.de>
 <CA+G9fYsxOouFBgCBacXzdimJUfZ3DXVAia6XL7kCvcQX7qgOnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgBCNsK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Feb 2020 08:48:10 -0500
In-Reply-To: <CA+G9fYsxOouFBgCBacXzdimJUfZ3DXVAia6XL7kCvcQX7qgOnA@mail.gmail.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org

On 2/3/20 2:43 PM, Naresh Kamboju wrote:
> On Fri, 24 Jan 2020 at 18:57, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>
>> All user space generated SKBs are owned by a socket (unless injected
>> into the key via AF_PACKET). If a socket is closed, all associated skbs
>> will be cleaned up.
>>
>> This leads to a problem when a CAN driver calls can_put_echo_skb() on a
>> unshared SKB. If the socket is closed prior to the TX complete handler,
>> can_get_echo_skb() and the subsequent delivering of the echo SKB to
>> all registered callbacks, a SKB with a refcount of 0 is delivered.
>>
>> To avoid the problem, in can_get_echo_skb() the original SKB is now
>> always cloned, regardless of shared SKB or not. If the process exists it
>> can now safely discard its SKBs, without disturbing the delivery of the
>> echo SKB.
>>
>> The problem shows up in the j1939 stack, when it clones the
>> incoming skb, which detects the already 0 refcount.
>>
>> We can easily reproduce this with following example:
>>
>> testj1939 -B -r can0: &
>> cansend can0 1823ff40#0123
>>
>> WARNING: CPU: 0 PID: 293 at lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
>> refcount_t: addition on 0; use-after-free.
> 
> FYI,
> This issue noticed in our Linaro test farm
> On linux next version 5.5.0-next-20200203 running on beagleboard x15 arm device.
> 
> Thanks for providing fix for this case.

Can we add your Tested-by to the patch?

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
