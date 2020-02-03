From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [RFC] can: can_create_echo_skb(): fix echo skb generation: always
 use skb_clone()
Date: Mon, 3 Feb 2020 20:06:28 +0530
Message-ID: <CA+G9fYv8mnoSoJp0fw4TqpoJweSh0C2KVih=f9MYK20=H=6fGA@mail.gmail.com>
References: <20200124132656.22156-1-o.rempel@pengutronix.de>
 <CA+G9fYsxOouFBgCBacXzdimJUfZ3DXVAia6XL7kCvcQX7qgOnA@mail.gmail.com>
 <7ee9df43-2efb-ba57-c8a9-301bae12c0d7@pengutronix.de> <b0aa1582-98d0-6929-da8d-879151c49654@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b0aa1582-98d0-6929-da8d-879151c49654@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, linux-can@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

On Mon, 3 Feb 2020 at 19:22, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 2/3/20 2:48 PM, Marc Kleine-Budde wrote:
> >>> WARNING: CPU: 0 PID: 293 at lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
> >>> refcount_t: addition on 0; use-after-free.
> >>
> >> FYI,
> >> This issue noticed in our Linaro test farm
> >> On linux next version 5.5.0-next-20200203 running on beagleboard x15 arm device.
> >>
> >> Thanks for providing fix for this case.
>
> Please look closely at your backtraces, they are totally unrelated. It
> seems the whole culprit in your testcase fails with:
>
> > [    0.000000] OF: ERROR: Bad of_node_put() on /ocp/interconnect@4a000000/segment@0/target-module@8000/cm_core@0/l4per-cm@1700/l4per-clkctrl@28

I have reported on another email regarding this dtb issue.

>
> ...the rest are subsequent faults.
>
> > Can we add your Tested-by to the patch?

We generally test linux mainline, linux-next, LTS 5.4, 4.19, 4.14, 4.9
and 4.4 branches.
When issue like this found and with a proposed fix patch.
I do schedule it for apply patch and test and report it back on email thread.

- Naresh
