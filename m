From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] can: flexcan: fix deadlock when using self wakeup
Date: Sat, 8 Jun 2019 19:41:30 +0200
Message-ID: <fbbe474f-bdf7-a97a-543d-da17dfd2a114@geanix.com>
References: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 17/05/2019 04.39, Joakim Zhang wrote:
> As reproted by Sean Nyekjaer bellow:
> When suspending, when there is still can traffic on the
> interfaces the flexcan immediately wakes the platform again.
> As it should :-)
> But it throws this error msg:
> [ 3169.378661] PM: noirq suspend of devices failed
> 
> On the way down to suspend the interface that throws the error
> message does call flexcan_suspend but fails to call
> flexcan_noirq_suspend.
> That means the flexcan_enter_stop_mode is called, but on the way
> out of suspend the driver only calls flexcan_resume and skips
> flexcan_noirq_resume, thus it doesn't call flexcan_exit_stop_mode.
> This leaves the flexcan in stop mode, and with the current driver
> it can't recover from this even with a soft reboot, it requires a
> hard reboot.
> 
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> 
> This patch intends to fix the issue, and also add comment to explain the
> wakeup flow.
> Reported-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

How is it going with the updated patch?

/Sean
