From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] can: m_can_platform: fix m_can_runtime_suspend()
Date: Mon, 8 Jun 2020 09:27:52 -0500
Message-ID: <b9510aa6-d865-7c4f-6730-dcd207bdb753@ti.com>
References: <20200608094348.12650-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200608094348.12650-1-richard.genoud@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Sriram Dash <sriram.dash@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Richard

On 6/8/20 4:43 AM, Richard Genoud wrote:
> Since commit f524f829b75a ("can: m_can: Create a m_can platform
> framework"), the can peripheral on STM32MP1 wasn't working anymore.
>
> The reason was a bad copy/paste maneuver that added a call to
> m_can_class_suspend() in m_can_runtime_suspend().

Are you sure it was a copy paste error?

Probably don't want to have an unfounded cause unless you know for 
certain it was this.

Dan
