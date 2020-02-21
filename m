From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN
 driver
Date: Fri, 21 Feb 2020 08:25:54 -0600
Message-ID: <06af6e1d-aec4-189c-378a-77af4073a1a6@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
 <20200131183433.11041-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgBUObN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2020 09:31:13 -0500
In-Reply-To: <20200131183433.11041-2-dmurphy@ti.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net

Hello

On 1/31/20 12:34 PM, Dan Murphy wrote:
> Move the clock discovery and initialization from the m_can framework to
> the registrar.  This allows for registrars to have unique clock
> initialization.  The TCAN device only needs the CAN clock reference.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

I would like to have these 3 patches reviewed and integrated (post 
review) so I can work on other issues identified.

Dan
