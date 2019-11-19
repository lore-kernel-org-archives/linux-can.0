From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] can: m_can_platform: remove unnecessary
 m_can_class_resume() call
Date: Tue, 19 Nov 2019 08:45:30 -0600
Message-ID: <0af3a926-fa28-2ddd-a6ef-1c516f674fc9@ti.com>
References: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
 <CGME20191119102201epcas5p4e215c25d5d07269a7afb1f86fac0be65@epcas5p4.samsung.com>
 <1574158838-4616-3-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574158838-4616-3-git-send-email-pankj.sharma@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, rcsekar@samsung.com, pankaj.dubey@samsung.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

Pankaj

On 11/19/19 4:20 AM, Pankaj Sharma wrote:
> The function m_can_runtime_resume() is getting recursively called from
> m_can_class_resume(). This results in a lock up.
>
> We need not call m_can_class_resume() during m_can_runtime_resume().
>
> Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
>
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
>   drivers/net/can/m_can/m_can_platform.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 2eaa354..38ea5e6 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -166,8 +166,6 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
>   	if (err)
>   		clk_disable_unprepare(mcan_class->hclk);
>   
> -	m_can_class_resume(dev);
> -
>   	return err;
>   }
>   
Acked-by: Dan Murphy <dmurphy@ti.com>
