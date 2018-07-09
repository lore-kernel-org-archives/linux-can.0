From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 9 Jul 2018 16:35:36 -0300
Message-ID: <CAOMZO5BD+jgwz+X6vs=AiprQJ_-EtT6M_Nm1MoUUT2bBQKDTKQ@mail.gmail.com>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com> <20180709193157.GB17865@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709193157.GB17865@osadl.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Mon, Jul 9, 2018 at 4:31 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:

> I don=C2=B4t think so the code above this part return 0 on error and a
> valid frequency on success so returning -ENOMEM would probably be
> mistaken as a frequency !

Now that I looked closely in the function context I see it makes sense
to return 0 :-)

Thanks
