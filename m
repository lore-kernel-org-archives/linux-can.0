From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: Replace zero-length array with flexible-array
Date: Thu, 4 Jun 2020 08:31:55 +0200
Message-ID: <74c08a71-afb5-aba4-2c30-c342b4a7e61f@hartkopp.net>
References: <20200507185118.GA14022@embeddedor>
 <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
 <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Gustavo,

On 04.06.20 02:58, Gustavo A. R. Silva wrote:

> Sorry for the late reply. I totally lost track of this thread. :/

NP. At least your workflow seems to work :o)

> pahole shows exactly the same output either if cf is a zero-length array or
> a flexible-array member:
> 
> $ pahole -C 'can_skb_priv' drivers/net/can/dev.o
> 
> struct can_skb_priv {
> 	int                        ifindex;              /*     0     4 */
> 	int                        skbcnt;               /*     4     4 */
> 	struct can_frame           cf[] __attribute__((__aligned__(8))); /*     8     0 */
> 
> 	/* size: 8, cachelines: 1, members: 3 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));
> 
> So, it seems everything should fine. :)

Great! Thanks for the info - and how I could have checked it on my own, too.

Best,
Oliver
