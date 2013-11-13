From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/3] can: mcp251x: Convert driver to use common clk
 framework
Date: Wed, 13 Nov 2013 17:59:01 +0000 (UTC)
Message-ID: <l60el5$2kn$1@ger.gmane.org>
References: <1384332144-15211-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

On Wed, 13 Nov 2013 12:42:24 +0400, Alexander Shiyan wrote:

> This patch converts mcp251x driver to using common clk framework for
> getting input frequency. The change was made for the preparation of the
> driver work with the devicetree. As a result private header for the
> driver is eliminated.
> Additionally, all existing users of the driver was converted to use this
> feature.


PXA does not employ COMMON_CLK yet (WIP locally, but it is not finished 
yet), so clk_register_fixed() will probably fail.

-- 
With best wishes
Dmitry
