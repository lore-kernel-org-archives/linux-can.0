From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH] can: mcp251x: add error check when wq alloc failed
Date: Tue, 25 Jun 2019 10:03:56 -0400
Message-ID: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
References: <20190625125048.28849-1-houweitaoo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625125048.28849-1-houweitaoo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weitao Hou <houweitaoo@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, allison@lohutok.net, tglx@linutronix.de, sean@geanix.com, linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Tue, Jun 25, 2019 at 8:51 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>
> add error check when workqueue alloc failed, and remove
> redundant code to make it clear
>
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>
