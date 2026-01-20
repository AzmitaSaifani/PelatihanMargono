    import express from "express";
    import connection from "../../config/db.js";
    import { logAdmin } from "../../routes/auth/adminLogger.js";

    const router = express.Router();

    // Update
    router.put("/:id", (req, res) => {
    const sql = `
        UPDATE tim_kerja
        SET jabatan = ?, deskripsi = ?
        WHERE id = ?
    `;

    connection.query(sql, [
        req.body.jabatan,
        req.body.deskripsi,
        req.params.id,
    ], (err) => {
        if (err) return res.status(500).json(err);

        logAdmin({
        id_user: req.user.id,
        email: req.user.email,
        nama_lengkap: req.user.nama_lengkap,
        aktivitas: "UPDATE TIM KERJA",
        keterangan: `Update tim kerja ID ${req.params.id}`,
        req,
        });

        res.json({ message: "Tim kerja diperbarui" });
    });
    });

    // Delete
    router.delete("/:id", (req, res) => {
    const { id } = req.params;

    connection.query(
        "DELETE FROM tim_kerja WHERE id = ?",
        [id],
        (err, result) => {
        if (err) return res.status(500).json(err);

        // ✅ LOG ADMIN (DELETE)
        logAdmin({
            id_user: req.user.id,
            email: req.user.email,
            nama_lengkap: req.user.nama_lengkap,
            aktivitas: "DELETE TIM KERJA",
            keterangan: `Menghapus tim kerja ID ${id}`,
            req,
        });

        res.json({ message: "Tim kerja berhasil dihapus" });
        }
    );
    });

    export default router;
