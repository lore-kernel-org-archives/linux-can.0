From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
Date: Fri, 15 Nov 2019 10:07:40 +0100
Message-ID: <9870ec21-b664-522e-e0df-290ab56fbb32@geanix.com>
References: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 15/11/2019 06.03, Joakim Zhang wrote:
> From: Sean Nyekjaer <sean@geanix.com>
> 
> When suspending, when there is still can traffic on the interfaces the
> flexcan immediately wakes the platform again. As it should :-). But it
> throws this error msg:
> [ 3169.378661] PM: noirq suspend of devices failed
> 
> On the way down to suspend the interface that throws the error message does
> call flexcan_suspend but fails to call flexcan_noirq_suspend. That means the
> flexcan_enter_stop_mode is called, but on the way out of suspend the driver
> only calls flexcan_resume and skips flexcan_noirq_resume, thus it doesn't call
> flexcan_exit_stop_mode. This leaves the flexcan in stop mode, and with the
> current driver it can't recover from this even with a soft reboot, it requires
> a hard reboot.
> 
> This patch can fix deadlock when using self wakeup, it happenes to be
> able to fix another issue that frames out-of-order in first IRQ handler
> run after wakeup.
> 
> In wakeup case, after system resume, frames received out-of-order,the
> problem is wakeup latency from frame reception to IRQ handler is much
> bigger than the counter overflow. This means it's impossible to sort the
> CAN frames by timestamp. The reason is that controller exits stop mode
> during noirq resume, then it can receive the frame immediately. If
> noirq reusme stage consumes much time, it will extend interrupt response
> time.
> 
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Hi Joakim and Marc

We have quite a few devices in the field where flexcan is stuck in 
Stop-Mode. We do not have the possibility to cold reboot them, and hot 
reboot will not get flexcan out of stop-mode.
So flexcan comes up with:
[  279.444077] flexcan: probe of 2090000.flexcan failed with error -110
[  279.501405] flexcan: probe of 2094000.flexcan failed with error -110

They are on, de3578c198c6 ("can: flexcan: add self wakeup support")

Would it be a solution to add a check in the probe function to pull it 
out of stop-mode?

/Sean
