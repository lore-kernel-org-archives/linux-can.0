From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: linux-can/testing: Request for testing
Date: Thu, 10 Oct 2019 14:17:21 +0200
Message-ID: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
List-Id: linux-can.vger.kernel.org

Hello,

this patch series is the upcoming pull request for net/master.

One of the biggest changes is the cleanup of the error handling in the
rx-offload infrastructure. If queueing fails the skbs are now properly
freed.

Please test.

regards,
Marc
