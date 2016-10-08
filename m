From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Sat, 8 Oct 2016 21:48:20 +0200
Message-ID: <20161008194820.GC10286@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:45828 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbcJHTtW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Oct 2016 15:49:22 -0400
Content-Disposition: inline
In-Reply-To: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

Marc

I tried to replace a spinlock+int by an atomic_t.
Is it something similar that you had in mind.
You were right in your comments that it is replaceable by an atomic_t.
I pushed it to my repo, and appended it to this email.

David, this should be transparent, but I wasn't able to test it.

Kind regards,
Kurt

commit b8bfd1fe84869ee1c5eed3b8e6717da67dc3da60
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Sat Oct 8 21:43:04 2016

    can-j1939: replace spinlock+counter by atomic_t
    
    The skb_pending member of j1939 sockets does not really need an extra spinlock
    
    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 66d2301..41d59dd 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -57,8 +57,7 @@ struct j1939_sock {
 	 * when transport protocol comes in.
 	 * To allow emitting in order, keep a 'pending' nr. of packets
 	 */
-	int skb_pending;	/* TODO: convert to atomic_t */
-	spinlock_t lock;	/* protects skb_pending */
+	atomic_t skb_pending;
 	wait_queue_head_t waitq;
 };
 
@@ -67,42 +66,39 @@ static inline struct j1939_sock *j1939_sk(const struct sock *sk)
 	return container_of(sk, struct j1939_sock, sk);
 }
 
-/* skb_pending issues */
+/*
+ * j1939_sock_pending_add_first
+ * Succeeds when the first pending SKB is scheduled
+ * Fails when SKB are already pending
+ */
 static inline int j1939_sock_pending_add_first(struct sock *sk)
 {
-	int saved;
 	struct j1939_sock *jsk = j1939_sk(sk);
 
-	spin_lock_bh(&jsk->lock);
-	if (!jsk->skb_pending) {
-		++jsk->skb_pending;
-		saved = 1;
-	} else {
-		saved = 0;
-	}
-	spin_unlock_bh(&jsk->lock);
-	return saved;
+	/*
+	 * atomic_cmpxchg returns the old value
+	 * When it was 0, it is exchanged with 1 and this function
+	 * succeeded. (return 1)
+	 * When it was != 0, it is not exchanged, and this fuction
+	 * fails (returns 0).
+	 */
+	return !atomic_cmpxchg(&jsk->skb_pending, 0, 1);
 }
 
 static inline void j1939_sock_pending_add(struct sock *sk)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
 
-	spin_lock_bh(&jsk->lock);
-	++jsk->skb_pending;
-	spin_unlock_bh(&jsk->lock);
+	atomic_inc(&jsk->skb_pending);
 }
 
 void j1939_sock_pending_del(struct sock *sk)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
-	int saved;
 
-	spin_lock_bh(&jsk->lock);
-	--jsk->skb_pending;
-	saved = jsk->skb_pending;
-	spin_unlock_bh(&jsk->lock);
-	if (!saved)
+	/* atomic_dec_return returns the new value */
+	if (!atomic_dec_return(&jsk->skb_pending))
+		/* no pending SKB's */
 		wake_up(&jsk->waitq);
 }
 
@@ -209,13 +205,13 @@ static int j1939sk_init(struct sock *sk)
 	struct j1939_sock *jsk = j1939_sk(sk);
 
 	INIT_LIST_HEAD(&jsk->list);
-	spin_lock_init(&jsk->lock);
 	init_waitqueue_head(&jsk->waitq);
 	jsk->sk.sk_priority = j1939_to_sk_priority(6);
 	jsk->sk.sk_reuse = 1; /* per default */
 	jsk->addr.sa = J1939_NO_ADDR;
 	jsk->addr.da = J1939_NO_ADDR;
 	jsk->addr.pgn = J1939_NO_PGN;
+	atomic_set(&jsk->skb_pending, 0);
 	return 0;
 }
 
