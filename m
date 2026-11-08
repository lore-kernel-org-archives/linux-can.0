Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794109466;
	b=pqmo+4YxFGfhiXpx16B/qdzIG1wJM6PjSuafjwlWX70vLv6zyk8ZEl0D88tB1D4+V+2n
	 lObfXD4v0L4voLIQZ8I58DY27PEkgFnac24Iejh/ZEImKRtW7juEH3iXxW2EPuPDhvTwq
	 Rrzi48oY17d8ZiCeusqwBDnR/V+mE2oiQDP0501PiWJoR3iTFTg1RR3Vplq9ptax0/A6g
	 3QeoaOsd+TqUdMTA2NnWC9rsAaLFc+XcQjcfGmzmIHwZIlQcHTB3XnowLe9M1qSqdpC1w
	 tMtQ1lnH7GZ0skIKhWCjWnejM/UDy4jQY5Zk0fyToAEh1ODH0Z9aaT42E0seZkcQjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794109466;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5OphwrrzSjJ8oM7Mb29MNlr0TI6+Wj3N2jDDdudxwVs=;
	b=FiqzJwjlrIS6ik5VbQENb7x70o5aATQ5jw69xxlmBgfR+EYlzfHjmaqn8waN6dbETH+n
	 rmReZFbTXk7i6PCvlwms047i6jyAADfRo7g3yA2DCkrUunRDySa6MkKB2mtOY3wHk6k0g
	 ANH4AW5q+Db/0D05GIah52DEAVMWOnT2AcT70y+rL28XulkhoAE2qiEGy4HN4x33NDvD1
	 7JpcfEErx3OgzmeFKm5YX1UQvVY6OcveczT5mjQ30YJzpmenXRKBzcQLxvByN1Lem4ef5
	 aWYJC1sfHQYaWwkOu3jnVDtt/m7t+sGeG9RiEvzDFF3Cz4ripC8UaBsTW+d0AbLNMLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SnaNe0o2;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A145606A31A
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 03:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A145606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SnaNe0o2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=5OphwrrzSjJ8oM7Mb29MNlr0TI6+Wj3N2jDDdudxwVs=;
	b=SnaNe0o2xIDSPg6LJ+3hZFel+wjmVBDQcijX/nk8VMJEIqKPognJzMQPeEtX+l
	Qdl00w60V+3oLWwxg+9sP9YKM+QjmtLb9r7geIMkmlEh7BeMv1ctw9re/a+4mMer
	aRncH0gjiOVZGRcqsk3PgWEOsVUfHcmSn+MiBKNL27XsI=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/3] dt-bindings: net: can: convert three bindings to DT schema
Date: Sun, 08 Nov 2026 11:22:12 +0800
Message-ID: <179410813231.146889.13663462288333805265@163.com>
In-Reply-To: <20260922102258.138753-1-quchaosheng000406@163.com>
References: <20260922102258.138753-1-quchaosheng000406@163.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnZx4K8O9qF7lzEQ--.22608S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RX4SFUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5A3VS2rv8A3aOQAA3s

Hi Marc,

A gentle ping on this one - v8 was posted on 2026-09-22 and Rob gave his
Reviewed-by on all three conversions in that round.  I have not seen it in
either of your recent pull requests (can-next 2026-10-22, can 2026-11-03),
and the three .txt files are still in master, so I would rather ask than
keep resending:

  https://lore.kernel.org/all/20260922102258.138753-1-quchaosheng000406@163.com/

Is the series queued somewhere I cannot see, or would you prefer it
dropped?  Either answer closes this off for me - I am not looking to
resend unless something in it needs changing.

Thanks,
Chaosheng

