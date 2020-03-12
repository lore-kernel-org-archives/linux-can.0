From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: slcan, slip -- no need for goto when if () will do
Date: Wed, 11 Mar 2020 23:15:51 -0700 (PDT)
Message-ID: <20200311.231551.178115854707336170.davem@davemloft.net>
References: <20200309223323.GA1634@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309223323.GA1634@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, yangerkun@huawei.com, mkl@pengutronix.de, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 9 Mar 2020 23:33:23 +0100

> No need to play with gotos to jump over single statement.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.
