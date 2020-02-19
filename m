From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH linux-master 0/3] MCAN updates for clock discovery
Date: Wed, 19 Feb 2020 07:07:19 -0600
Message-ID: <a97ed7ef-e95a-af32-4d01-2ed7c2c08c20@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net
List-Id: linux-can.vger.kernel.org

Bump

On 1/31/20 12:34 PM, Dan Murphy wrote:
> Hello
>
> These are the initial fixes for issues found in and requested in
> https://lore.kernel.org/patchwork/patch/1165091/
>
> For the clock discovery and initialization.
>
> Dan
>
> Dan Murphy (3):
>    can: tcan4x5x: Move clock init to TCAN driver
>    can: m_can_platform: Move clock discovery and init to platform
>    can: m_can: Remove unused clock function from the framework
>
>   drivers/net/can/m_can/m_can.c          | 16 ------
>   drivers/net/can/m_can/m_can.h          |  3 -
>   drivers/net/can/m_can/m_can_platform.c | 37 +++++++++---
>   drivers/net/can/m_can/tcan4x5x.c       | 78 +++++++++++++++++++-------
>   4 files changed, 89 insertions(+), 45 deletions(-)
>
