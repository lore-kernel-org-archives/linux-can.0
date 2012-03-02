From: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Subject: [PATCH 0/3 v8] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Fri,  2 Mar 2012 16:13:03 +0100
Message-ID: <1330701186-28734-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-can Mailing List <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-usb Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
List-Id: linux-can.vger.kernel.org

That serie of patches adds the peak_usb driver which handles the PCAN-USB
and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com).
These patches are planned for kernel v3.03.00 and above.

Stephane Grosjean (3):

  v8 changelog: 
  - fix v7 patches serie non breakable issue

  can/usb: PEAK-System Technik USB adapters driver core
  can/usb: PEAK-System Technik PCAN-USB specific part
  can/usb: PEAK-System Technik PCAN-USB Pro specific part

 drivers/net/can/usb/Kconfig                  |    6 +
 drivers/net/can/usb/Makefile                 |    1 +
 drivers/net/can/usb/peak_usb/Makefile        |    2 +
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  901 ++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  951 +++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  146 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1036 ++++++++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  178 +++++
 8 files changed, 3221 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/usb/peak_usb/Makefile
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
 create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h

-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
