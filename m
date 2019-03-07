From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] peak_usb: fix clang build warning
Date: Thu, 7 Mar 2019 16:38:53 +0100
Message-ID: <CAK8P3a3zxEKynY03m5Z67Zo1WMO=fNdKu1PXp0r=21x_QRNqUQ@mail.gmail.com>
References: <20190307103219.1539316-1-arnd@arndb.de> <20190307153143.GI20201@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307153143.GI20201@archlinux-ryzen>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Nick Desaulniers <ndesaulniers@google.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-can@vger.kernel.org, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Thu, Mar 7, 2019 at 4:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Mar 07, 2019 at 11:31:55AM +0100, Arnd Bergmann wrote:
> > Clang points out undefined behavior when building the pcan_usb_pro driver:
> >
> > drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]
> >
> > Changing the function prototype to avoid argument promotion in the
> > varargs call avoids the warning, and should make this well-defined.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/109
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks!

> I wonder if the format specifier in the pr_err statement at the end of
> this function should be updated.

I think it's still ok as it is.

      Arnd
