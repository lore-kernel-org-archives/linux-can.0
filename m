From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in
 register_candev()
Date: Wed, 26 Jun 2019 09:03:56 -0700 (PDT)
Message-ID: <20190626.090356.252151230739268701.davem@davemloft.net>
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
        <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
        <ff8160d4-3357-9b4f-1840-bbe46195da5a@prevas.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff8160d4-3357-9b4f-1840-bbe46195da5a@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: rasmus.villemoes@prevas.dk
Cc: willemdebruijn.kernel@gmail.com, wg@grandegger.com, mkl@pengutronix.de, Rasmus.Villemoes@prevas.se, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 26 Jun 2019 09:31:39 +0000

> Perhaps I've misunderstood when to use the net-next prefix - is that
> only for things that should be applied directly to the net-next
> tree?

Yes, it is.
