From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2018-11-28,pull-request: can-next
 2018-11-28
Date: Wed, 28 Nov 2018 11:21:57 -0800 (PST)
Message-ID: <20181128.112157.1875553528431620394.davem@davemloft.net>
References: <98eab65a-24c5-aba6-d4f0-746d7758d5ce@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <98eab65a-24c5-aba6-d4f0-746d7758d5ce@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 28 Nov 2018 17:01:13 +0100

>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-4.21-20181128

This doesn't work for me at all.

I'm not adding a custom .ssh config entry to point gitolite.kernel.org
to the same SSH key that I use for gitolite@ra.kernel.org, no way.

I don't want to see these SSH based URLs any more, they are a pain and
add overhead to my workflow.

Please just use plain git:// URLs, thank you.
