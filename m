From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 15 May 2019 15:54:12 -0500
Message-ID: <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509161109.10499-1-dmurphy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

On 5/9/19 11:11 AM, Dan Murphy wrote:
> Create a m_can platform framework that peripheral
> devices can register to and use common code and register sets.
> The peripheral devices may provide read/write and configuration
> support of the IP.
> 
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v12 - Update the m_can_read/write functions to create a backtrace if the callback
> pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
> 

Is this able to be merged now?

Dan

<snip>
