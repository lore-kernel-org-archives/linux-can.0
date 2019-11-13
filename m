From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2019-11-13
Date: Wed, 13 Nov 2019 11:47:19 -0800 (PST)
Message-ID: <20191113.114719.1129176458430744862.davem@davemloft.net>
References: <20191113095550.26527-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191113095550.26527-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 13 Nov 2019 10:55:41 +0100

> this is a pull request of 9 patches for net/master, hopefully for the v5.4
> release cycle.
> 
> All nine patches are by Oleksij Rempel and fix locking and use-after-free bugs
> in the j1939 stack found by the syzkaller syzbot.

Pulled, thanks Marc.
