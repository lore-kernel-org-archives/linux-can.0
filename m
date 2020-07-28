From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] can: m_can: Set device to software init mode before
 closing
Date: Tue, 28 Jul 2020 11:50:48 +0530
Message-ID: <1491e746-6694-1c36-4bba-ac9f61d9ae6f@ti.com>
References: <20200716042312.26989-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716042312.26989-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com
List-Id: linux-can.vger.kernel.org

Hi,

On 16/07/20 9:53 am, Faiz Abbas wrote:
> There might be some requests pending in the buffer when the
> interface close sequence occurs. In some devices, these
> pending requests might lead to the module not shutting down
> properly when m_can_clk_stop() is called.
> 
> Therefore, move the device to init state before potentially
> powering it down.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 02c5795b7393..d0c458f7f6e1 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1414,6 +1414,9 @@ static void m_can_stop(struct net_device *dev)
>  	/* disable all interrupts */
>  	m_can_disable_all_interrupts(cdev);
>  
> +	/* Set init mode to disengage from the network */
> +	m_can_config_endisable(cdev, true);
> +
>  	/* set the state as STOPPED */
>  	cdev->can.state = CAN_STATE_STOPPED;
>  }
> 

Gentle ping.

Thanks,
Faiz
