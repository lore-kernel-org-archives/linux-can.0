From: Austin Hendrix <namniart@gmail.com>
Subject: [PATCH] sllin: update for kernels > 3.11
Date: Mon, 25 Apr 2016 15:46:53 -0700
Message-ID: <571E9E5D.3000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35291 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcDYWq4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 18:46:56 -0400
Received: by mail-io0-f172.google.com with SMTP id d62so146380iof.2
        for <linux-can@vger.kernel.org>; Mon, 25 Apr 2016 15:46:55 -0700 (PDT)
Received: from [172.16.131.128] ([50.233.131.66])
        by smtp.googlemail.com with ESMTPSA id rn3sm10115236igb.14.2016.04.25.15.46.54
        for <linux-can@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 15:46:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm experimenting with sllin ( https://rtime.felk.cvut.cz/can/lin-bus/ 
), and I've found that it doesn't compile on linux kernels newer than 
3.11, so I've patched it to compile and (hopefully) run on newer kernels.

I've verified that these changes compile and the resulting module loads 
on the 4.2.0 kernel on my Ubuntu machine, but I don't have LIN hardware 
yet and haven't tried attaching the LIN serial line discipline to a 
serial port.

In the event that this driver is no longer maintained, I'm also hosting 
my copy of the source on github: https://github.com/trainman419/linux-lin

Author: Austin Hendrix <namniart@gmail.com>
Date:   Mon Apr 25 10:41:13 2016 -0700

     Update for changes in recent linux kernels

Signed-off-by: Austin Hendrix <namniart@gmail.com>
diff --git a/sllin/sllin.c b/sllin/sllin.c

index 8d7ad69..2db896f 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -210,7 +210,11 @@ static int sltty_change_speed(struct tty_struct 
*tty, unsigned speed)
      struct ktermios old_termios, termios;
      int cflag;

+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 12, 0)
      mutex_lock(&tty->termios_mutex);
+#else
+    down_write(&tty->termios_rwsem);
+#endif

  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
      old_termios = termios = *(tty->termios);
@@ -238,7 +242,11 @@ static int sltty_change_speed(struct tty_struct 
*tty, unsigned speed)
      if (tty->ops->set_termios)
          tty->ops->set_termios(tty, &old_termios);

+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 12, 0)
      mutex_unlock(&tty->termios_mutex);
+#else
+    up_write(&tty->termios_rwsem);
+#endif

      return 0;
  }
@@ -311,7 +319,12 @@ static void sllin_write_wakeup(struct tty_struct *tty)
              return;    /* ongoing concurrent processing */

          clear_bit(SLF_TXBUFF_RQ, &sl->flags);
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 18, 0)
          smp_mb__after_clear_bit();
+#else
+        smp_mb__after_atomic();
+#endif

          if (sl->lin_state != SLSTATE_BREAK_SENT)
              remains = sl->tx_lim - sl->tx_cnt;
@@ -325,7 +338,11 @@ static void sllin_write_wakeup(struct tty_struct *tty)
              remains -= actual;
          }
          clear_bit(SLF_TXBUFF_INPR, &sl->flags);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 18, 0)
          smp_mb__after_clear_bit();
+#else
+        smp_mb__after_atomic();
+#endif

      } while (unlikely(test_bit(SLF_TXBUFF_RQ, &sl->flags)));

@@ -838,7 +855,11 @@ static int sllin_send_tx_buff(struct sllin *sl)
              return 0;    /* ongoing concurrent processing */

          clear_bit(SLF_TXBUFF_RQ, &sl->flags);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 18, 0)
          smp_mb__after_clear_bit();
+#else
+        smp_mb__after_atomic();
+#endif

  #ifdef BREAK_BY_BAUD
          if (sl->lin_state != SLSTATE_BREAK_SENT)
@@ -872,7 +893,11 @@ static int sllin_send_tx_buff(struct sllin *sl)
                  sl->tx_cnt, remains);

          clear_bit(SLF_TXBUFF_INPR, &sl->flags);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 18, 0)
          smp_mb__after_clear_bit();
+#else
+        smp_mb__after_atomic();
+#endif

      } while (unlikely(test_bit(SLF_TXBUFF_RQ, &sl->flags)));

@@ -1337,7 +1362,12 @@ static struct sllin *sll_alloc(dev_t line)
          char name[IFNAMSIZ];
          sprintf(name, "sllin%d", i);

+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0))
          dev = alloc_netdev(sizeof(*sl), name, sll_setup);
+#else
+        dev = alloc_netdev(sizeof(*sl), name, NET_NAME_UNKNOWN, sll_setup);
+#endif
+
          if (!dev)
              return NULL;
          dev->base_addr  = i;


