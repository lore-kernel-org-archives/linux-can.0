From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] peak_usb: fix clang build warning
Date: Thu, 7 Mar 2019 08:31:43 -0700
Message-ID: <20190307153143.GI20201@archlinux-ryzen>
References: <20190307103219.1539316-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307103219.1539316-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Nick Desaulniers <ndesaulniers@google.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Thu, Mar 07, 2019 at 11:31:55AM +0100, Arnd Bergmann wrote:
> Clang points out undefined behavior when building the pcan_usb_pro driver:
> 
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]
> 
> Changing the function prototype to avoid argument promotion in the
> varargs call avoids the warning, and should make this well-defined.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Link: https://github.com/ClangBuiltLinux/linux/issues/109
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

I wonder if the format specifier in the pr_err statement at the end of
this function should be updated.

> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index d516def846ab..b388406ac0f5 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -127,7 +127,7 @@ static u8 *pcan_msg_init_empty(struct pcan_usb_pro_msg *pm,
>  /*
>   * add one record to a message being built
>   */
> -static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
> +static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, int id, ...)
>  {
>  	int len, i;
>  	u8 *pc;
> -- 
> 2.20.0
> 
