From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: can_create_echo_skb(): fix echo skb generation: always
 use skb_clone()
Date: Mon, 3 Feb 2020 14:52:54 +0100
Message-ID: <b0aa1582-98d0-6929-da8d-879151c49654@pengutronix.de>
References: <20200124132656.22156-1-o.rempel@pengutronix.de>
 <CA+G9fYsxOouFBgCBacXzdimJUfZ3DXVAia6XL7kCvcQX7qgOnA@mail.gmail.com>
 <7ee9df43-2efb-ba57-c8a9-301bae12c0d7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58791 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgBCNxA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Feb 2020 08:53:00 -0500
In-Reply-To: <7ee9df43-2efb-ba57-c8a9-301bae12c0d7@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: dev.kurt@vandijck-laurijssen.be, Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, linux-can@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, wg@grandegger.com

On 2/3/20 2:48 PM, Marc Kleine-Budde wrote:
>>> WARNING: CPU: 0 PID: 293 at lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
>>> refcount_t: addition on 0; use-after-free.
>>
>> FYI,
>> This issue noticed in our Linaro test farm
>> On linux next version 5.5.0-next-20200203 running on beagleboard x15 arm device.
>>
>> Thanks for providing fix for this case.

Please look closely at your backtraces, they are totally unrelated. It
seems the whole culprit in your testcase fails with:

> [    0.000000] OF: ERROR: Bad of_node_put() on /ocp/interconnect@4a000000/segment@0/target-module@8000/cm_core@0/l4per-cm@1700/l4per-clkctrl@28

...the rest are subsequent faults.

> Can we add your Tested-by to the patch?

Answering myself: NO!

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
