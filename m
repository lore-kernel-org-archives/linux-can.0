From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC] net: sch_generic: fq_codel vs pfifo_fast
Date: Wed, 27 Mar 2019 17:56:30 +0100
Message-ID: <20190327165632.10711-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
List-Id: linux-can.vger.kernel.org

Hello,

on CAN networking hardware we (the CAN community) experience a lot silent,
unwanted frame drops inside the kernel. (See first patch for details.) So
here's a patch series to keep pfifo_fast as default scheduler for CAN hardware
by default.

Consider this as an RFC. Regards,
Marc
