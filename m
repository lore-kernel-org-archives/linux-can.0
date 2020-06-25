From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH BUGFIX] can: m_can: make m_can driver work with sleep
 state pinconfig
Date: Thu, 25 Jun 2020 09:13:03 -0500
Message-ID: <9416850b-73c3-9b1c-6dd0-c49665ab3ec1@ti.com>
References: <20200625142435.50371e2f@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200625142435.50371e2f@ipc1.ka-ro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Sriram Dash <sriram.dash@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Lothar

On 6/25/20 7:24 AM, Lothar Waßmann wrote:
> Hi,
>
> When trying to use the m_can driver on an stm32mp15 based system, I
> found that I could not send or receive any data.
> Analyzing the pinctrl registers revealed, that the pins were
> configured for sleep state even when the can interfaces were in use.
>
> Looking at the m_can_platform.c driver I found that:
>
> commit f524f829b75a ("can: m_can: Create a m_can platform framework")
>
> introduced a call to m_can_class_suspend() in the m_can_runtime_suspend()
> function which wasn't there in the original code and which causes the
> pins used by the controller to be configured for sleep state.
>
> commit 0704c5743694 ("can: m_can_platform: remove unnecessary m_can_class_resume() call")
> already removed a bogus call to m_can_class_resume() from the
> m_can_runtime_resume() function, but failed to remove the matching
> call to m_can_class_suspend() from the m_can_runtime_suspend() function.
>
> Removing the bogus call to m_can_class_suspend() in the
> m_can_runtime_suspend() function fixes this.

Thank you for the patch Richard G has already submitted a similar patch

https://lore.kernel.org/patchwork/patch/1253401/

Dan
