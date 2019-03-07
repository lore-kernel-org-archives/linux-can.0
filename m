From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] peak_usb: fix clang build warning
Date: Thu, 07 Mar 2019 09:40:13 -0800 (PST)
Message-ID: <20190307.094013.220142928583766646.davem@davemloft.net>
References: <20190307103219.1539316-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307103219.1539316-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: wg@grandegger.com, mkl@pengutronix.de, ndesaulniers@google.com, gustavo@embeddedor.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 11:31:55 +0100

> Clang points out undefined behavior when building the pcan_usb_pro driver:
> 
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]
> 
> Changing the function prototype to avoid argument promotion in the
> varargs call avoids the warning, and should make this well-defined.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
