From: Sekar D <sekar.linux@gmail.com>
Subject: Session 152 terminated -- received PADT from peer
Date: Mon, 17 Jul 2017 12:07:10 +0530
Message-ID: <CAGc3wVBAcgaGFtzDVTksaLgs0CX=mirK7osVJRNM2_JjtNYM6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ppp-owner@vger.kernel.org>
Sender: linux-ppp-owner@vger.kernel.org
To: linux-ppp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello All,

I am getting the following error messages through PPP connection
without any manual intervention.

Session 152 terminated -- received PADT from peer
PADT: Generic-Error: RP-PPPoE: Child pppd process terminated
Sent PADT
Modem hangup
Exit
Connection terminated.
ADSL connection lost; attempting re-connection


Please let me know if any configuration needs to be added.

/etc/ppp/pppoe-server-options
# PPP options for the PPPoE server
# LIC: GPL
require-chap
login
lcp-echo-interval 10
lcp-echo-failure 2
